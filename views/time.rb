# Given a time, calculate the angle between the hour and minute hands on a clock.

def angle(time)
  # Every hour is 30 deg
  # Ever minute is 6 deg
  # Find difference between hour and min deg
  time = time.split(":").to_i
  hour = time[0]
  if hour == 12
    hour = 0
  else
    hour *= 30
  end
  if minute == 60
    minute = 0
  else
    minute *= 6
  end
  deg = (hour - minute).abs
end