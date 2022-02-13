require "../parser.cr"

def cmd_args(client, message)
  args = ParsedArgs.new message.content
  fmt = <<-FMT
  **Parsed Arguments**
  total args: #{args.raw.size} • code args: #{args.code.size}
  args: `#{args.raw}`
  
  FMT

  fmt = String.build do |string|
    string << <<-FMT
    **Parsed Arguments**
    total args: #{args.raw.size} • code args: #{args.code.size}
    args: `#{args.raw}`
    FMT

    string << "\nuser mentions: "
    if args.user_mentions.size != 0
      string << "\n" + args.user_mentions.map { |m| "<@#{m}>" }.join ", "
    else
      string << "none"
    end

    string << "\nchannel mentions: "
    if args.channel_mentions.size != 0
      string << "\n" + args.channel_mentions.map { |m| "<##{m}>" }.join ", "
    else
      string << "none"
    end

    if args.code.size != 0
      string << "\n```\n" + args.code.join(" ") + "\n```"
    end
  end

  client.create_message(message.channel_id, fmt)
end
