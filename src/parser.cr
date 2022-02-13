require "discordcr"

struct ParsedArgs
  getter cmd              : String
  getter content          : String
  getter raw              : Array(String)
  getter user_mentions    : Array(UInt64)
  getter channel_mentions : Array(UInt64)
  getter code             : Array(String)

  def initialize(msg : String)
    @content = msg
    @raw = parse_standard_args msg
    @cmd = @raw[0]
    @raw = @raw[1..]

    users, chans = parse_mentions msg
    @user_mentions = users
    @channel_mentions = chans
    @code = parse_codeblock @raw
  end

  def [](index)
    @raw[index]
  end
end

def parse_standard_args(msg : String) : Array(String)
  parsed = [] of String
  is_block = false

  msg.split(separator: " ", remove_empty: true).each do |arg|
    if arg == "```"
      is_block = !!is_block
    end

    next if is_block
    parsed << arg
  end

  parsed
end

def parse_codeblock(args : Array(String)) : Array(String)
  parsed = [] of String
  start = false

  return parsed if args.size == 0

  args.each do |arg|
    if arg.starts_with?("```") || arg.ends_with?("```")
      parsed << arg
      break if start
      start = true
      next
    end

    parsed << arg if start
  end

  fmt = parsed.join " "
  fmt = fmt.byte_slice 3
  fmt = fmt.byte_slice(1) if fmt.starts_with? '\n'
  fmt = fmt.chomp("```").chomp('\n')

  fmt.split " "
end

def parse_mentions(msg : String) : Array(Array(UInt64))
  users = [] of UInt64
  channels = [] of UInt64

  Discord::Mention.parse(msg) do |mention|
    case mention
    when Discord::Mention::User
      users << mention.id
    when Discord::Mention::Channel
      channels << mention.id
    else
      next
    end
  end

  [users, channels]
end
