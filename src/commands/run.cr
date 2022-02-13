require "../parser.cr"

def cmd_run(client, message)
  args = ParsedArgs.new message.content

  if args.code.size == 0
    client.create_message(
      message.channel_id,
      "No code provided! Make sure to put your code in codeblocks to run."
    )
    return
  end

  code = args.code.join " "
  msg = client.create_message(message.channel_id, "Running...")

  ts = Time.utc.millisecond
  temp = File.tempfile "run_#{ts}", ".cr"
  File.write temp.path, code

  `crystal run #{temp.path} > temp/out_#{ts}.txt`
  temp.delete

  res = File.read_lines "temp/out_#{ts}.txt"
  File.delete "temp/out_#{ts}.txt"

  if res.size == 0
    client.edit_message(
      message.channel_id, msg.id,
      "**Error:** Crystal didn't respond or returned an error!"
    )
  else
    fmt = "**Run Response:**\n```cr\n" + res.join("\n") + "\n```"
    client.edit_message(message.channel_id, msg.id, fmt)
  end
end
