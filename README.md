# iTunes Hook

Run `~/.ituneshook` executable when a song starts. It passes the current artist name, album and track.

[Download](https://dl.dropboxusercontent.com/u/1540890/iTunesHook.app.zip)

Just run the iTunesHook.app. This will start a background process that will be added to your login items.

Here's a sample script that displays the song info using `growlnotify`.

```bash
#!/usr/bin/env bash
artist=$1
album=$2
track=$3

/usr/local/bin/growlnotify -a /Applications/iTunes.app -t "${track}" -m "${artist} — ${album}"
```

## License

The MIT License (MIT)

Copyright (c) 2014 Nando Vieira

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
