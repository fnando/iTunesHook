# iTunes Hook

Run `~/.ituneshook` executable when a song starts. It passes the current artist name, album and track.

[Download](https://dl.dropboxusercontent.com/u/1540890/iTunesHook.app.zip)

Just run the iTunesHook.app. This will start a background process that will be added to your login items.

Here's a sample script that displays the song info using `growlnotify`.

```bash
#!/usr/bin/env bash
status=$1
artist=$2
album=$3
track=$4

[ "$status" == "playing" ] && /usr/local/bin/growlnotify -a /Applications/iTunes.app -t "${track}" -m "${artist} — ${album}"
```

And if you're more like a rubyist, here's what I've using:

```ruby
#!/usr/bin/env ruby
require 'net/http'
require 'uri'

class Notification
  attr_reader :artist, :album, :track

  def initialize(artist, album, track)
    @artist = normalize(artist)
    @album = normalize(album)
    @track = normalize(track)
  end

  def playing
  end

  def stopped
  end

  private

  def normalize(term)
    term
      .to_s
      .gsub(/'/, "’")
      .gsub(/(")([^"]+)(")/, "“\\2”")
  end
end

class Messages < Notification
  def playing
    system %[echo 'tell application "Messages" to set status message to "♫ %{artist} - %{track}"' | osascript] % {
      artist: artist,
      track: track
    }
  end

  def stopped
    system %[echo 'tell application "Messages" to set status message to ""' | osascript]
  end
end

class Growl < Notification
  def playing
    system '/usr/local/bin/growlnotify', '-a', '/Applications/iTunes.app', '-t', "#{track}", '-m', "#{artist} — #{album}"
  end
end

status = ARGV[0]
artist = ARGV[1]
album = ARGV[2]
track = ARGV[3]

[Messages, Growl].each do |notification_class|
  notification = notification_class.new(artist, album, track)
  notification.public_send(status) if notification.respond_to?(status)
end
```

## License

The MIT License (MIT)

Copyright (c) 2014 Nando Vieira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
