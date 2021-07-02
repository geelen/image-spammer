10.times do
  rando = `curl -sI https://source.unsplash.com/random`
  lines = rando.split("\n").map(&:strip)
  line = lines.find { |l| l =~ /^Location:/ }
  _, url, search = line.split(/[ ?]/)

  puts url
  path = URI(url).path

  `curl "#{url}" -o dist#{path}.jpg`
end

files = `ls dist`.split("\n")
File.write('dist/index.html', files.map { |f| "<img src='/#{f}' style='width: 40vw;'>" }.join())
