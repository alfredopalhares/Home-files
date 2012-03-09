# Before add message script 

# Add labels to mailing list i am subscribed

# By subject 
case message.subj
  # Sup talk
  when /\[sup-talk\]/i
    message.add_label "sup-talk"
  # Arch general
  when /\[arch-general\]/i
    message.add_label "arch-general"
  # Arch projects
  when /\[arch-projects\]/i
    message.add_label "arch-projects"
  # Exherbor 
  when /\[exherbo-dev\]/i
    message.add_label "exherbo"
  # Doxygen users
  when /\[doxygen-users\]/i
    message.add_label "doxygen-users"
  # Paparazzi-devel
  when /\[paparazzi-devel\]/i
    message.add_label "paparazzi-devel"
  # Latex
  when /\[texhax\]/i
    message.add_label "texhax"
end 

# By recipient 
to_string = message.recipients.map { |t| t.email }.join(" ") 
case to_string
  # lua 
  when /lua-l@lists.lua.org/
    message.add_label "lua"
  # Awesome WM
  when /awesome@naquadah.org/
    message.add_label "awesomewm"
  # Kernel Newbies
  when /kernelnewbies@kernelnewbies.org/
    message.add_label "kernelnewbies"
end
