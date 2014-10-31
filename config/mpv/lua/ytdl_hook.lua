local utils = require 'mp.utils'
local msg = require 'mp.msg'

mp.add_hook("on_load", 10, function ()

    local function exec(args)
        local ret = utils.subprocess({args = args})
      	return ret.status, ret.stdout
    end

    local url = mp.get_property("stream-open-filename")

    if (url:find("http://") == 1) or (url:find("https://") == 1)
        or (url:find("ytdl://") == 1) then

        -- strip ytdl://
        if (url:find("ytdl://") == 1) then
            url = url:sub(8)
        end

        local subformat = "srt"
        if url:find("crunchyroll") then
             subformat = "ass"
        end

        local es, json = exec({
            "youtube-dl", "-J", "--flat-playlist", "--all-subs",
            "--sub-format", subformat,  "--no-playlist", "--", url
            })

        if (es < 0) or (json == nil) or (json == "") then
            msg.error("youtube-dl failed.")
            mp.commandv("playlist_next", "force")

        else
            local json, err = utils.parse_json(json)

            if (json == nil) then
                msg.error("failed to parse JSON data: " .. err)
                mp.commandv("playlist_next", "force")
            else
                msg.info("youtube-dl succeeded!")

                -- what did we get?
                if not (json["_type"] == nil)
                    and (json["_type"] == "playlist") then -- a playlist

                    local playlist = "#EXTM3U\n"
                    for i, entry in pairs(json.entries) do
                        local site = entry.url

                        -- some extractors will still return the full info for
                        -- all clips in the playlist and the URL will point
                        -- directly to the file in that case, which we don't
                        -- want so get the webpage URL instead, which is what
                        -- we want
                        if not (entry["webpage_url"] == nil) then
                            site = entry["webpage_url"]
                        end

                        playlist = playlist .. "ytdl://" .. site .. "\n"
                    end

                    mp.set_property("stream-open-filename",
                        "memory://" .. playlist)

                else -- probably a video

                    local streamurl = json.url

                    msg.debug("streamurl: " .. streamurl)
                    mp.set_property("stream-open-filename", streamurl)

                    mp.set_property("file-local-options/media-title",
                        json.title)

                    -- add subtitles
                    if not (json.subtitles == nil) then
                        for lang, script in pairs(json.subtitles) do
                            msg.debug("adding subtitle ["..lang.."]")

                            local slang = lang
                            if (lang:len() > 3) then
                                slang = lang:sub(1,2)
                            end

                            mp.commandv("sub_add", "memory://"..script, "auto",
                                lang.." "..subformat, slang)
                        end
                    end

                    -- for rtmp
                    if not (json.play_path == nil) then
                        mp.set_property("file-local-options/stream-lavf-o",
                            "rtmp_tcurl=\""..streamurl..
                            "\",rtmp_playpath=\""..json.play_path.."\"")
                    end
                end
            end
        end
    end
end)
