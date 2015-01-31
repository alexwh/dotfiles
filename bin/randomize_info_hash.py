#!/usr/bin/env python2
# https://gist.github.com/hydrogen18/9ce5e525cde902be889d
import bencode
import sys
import random
import hashlib

if len(sys.argv) != 3 :
	sys.stderr.write(u'Usage: randomize_info_hash.py <torrent_file> <new_announce_url>\n')
	sys.exit(1)

with open(sys.argv[1],'r') as fin:
	torrent = bencode.bdecode(fin.read())

new_announce = sys.argv[2]

torrent['announce'] = new_announce
torrent['info']['x-cross-seed'] = '%x' % random.randint(0,1 << 31)

h = hashlib.sha1()
h.update(bencode.bencode(torrent['info']))
sys.stderr.write(u'Announce URL now:%s\n' % torrent['announce'])
sys.stderr.write(u'Info hash now:%s\n' % h.hexdigest())

sys.stdout.write(bencode.bencode(torrent))
sys.stdout.flush()
