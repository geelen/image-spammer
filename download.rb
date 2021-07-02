10.times do
  rando = `curl -sI https://source.unsplash.com/random`
  lines = rando.split("\n").map(&:strip)
  line = lines.find { |l| l =~ /^Location:/ }
  puts line
  _, url, search = line.split(/[ ?]/)

  `cd dist && curl "#{url}"`
end