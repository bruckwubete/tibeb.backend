#!/usr/bin/env ruby
#    uTorrent WebUI API Class for Ruby
#    Copyright (C) 2012  Keiran "Affix" Smith
#    http://affix.me
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
 
require 'rubygems'
require 'json'
require 'net/http'
 
 
class Utorrent extend self
 
	def get_token(hostname,port,user,pass)
 
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/token.html')
		        req.basic_auth user, pass
		        response = http.request(req)
		        token = response.body.gsub(%r{</?[^>]+?>}, '')
		        return token
		}
 
	end
 
	def get_torrents(hostname, port, user, pass, token)
		Net::HTTP.start(hostname, port) { |http|
			req = Net::HTTP::Get.new('/gui/?list=1&token=#{token}')
			req.basic_auth user, pass
			response = http.request(req)
			result = JSON.parse(response.body)
			torrents = result['torrents']
			return torrents
		}
	end
 
	def pause_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=pause&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
			return http.request(req)
		}
 
	end
 
	def start_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=start&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def stop_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=stop&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def forcestart_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=forcestart&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def unpause_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=unpause&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def recheck_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=recheck&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def remove_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=remove&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def removedata_torrent(hostname, port, user, pass, token, torrent_hash)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=removedata&token=#{token}&hash=#{torrent_hash}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def addurl_torrent(hostname, port, user, pass, token, torrent_url)
		Net::HTTP.start(hostname, port) { |http|
		        req = Net::HTTP::Get.new('/gui/?action=add-url&token=#{token}&s=#{torrent_url}')
		        req.basic_auth user, pass
		        return http.request(req)
		}
 
	end
 
	def addfile_torrent(hostname, port, user, pass, token, torrent_file)
		File.open(torrent_file) do |torrent|
			req = Net::HTTP::Post::Multipart.new "/gui/?action=add-file",
    				"file" => UploadIO.new(torrent, "application/x-bittorrent")
    			res = Net::HTTP.start(hostname, port) do |http|
    				http.basic_auth user, pass
    				return http.request(req)
    			end
 
		end
	end	
end