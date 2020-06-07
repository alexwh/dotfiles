import urllib.parse as ul
def urldecode(s):
    return ul.unquote_plus(s)
def urlencode(s):
    return ul.quote_plus(s)
