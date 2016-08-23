function checkFakeEvent(client,source)
  if client ~= source then
    client:banPlayer("Anticheat",999999999,"Manipuliertes Event")
    return false
  else
    return true
  end
end
