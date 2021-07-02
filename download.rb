require 'uri'

100.times do
  rando = `curl -sI https://source.unsplash.com/random`
  lines = rando.split("\n").map(&:strip)
  line = lines.find { |l| l =~ /^Location:/ }
  _, url = line.split(/ /)

  puts url
  path = URI(url).path
  file = File.basename(path)

  `curl "#{url.replace(/1080/,'3000')}" -o dist/#{file}.jpg`
end

files = `ls dist`.split("\n")
File.write('dist/index.html', files.map { |f| "<img src='/#{f}' style='width: 40vw;'>" }.join())
