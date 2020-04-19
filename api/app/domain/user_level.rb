def calc_user_level(user, totalExp)
  levelSetting = LevelSetting.find_by(level: user.level + 1)
  if levelSetting.present? && levelSetting.thresold <= user.experience_point
    user.level = user.level + 1
    user.update(level: user.level)
    totalExp = 0
  end
  until_percentage = totalExp.quo(levelSetting.thresold).to_f.round(2)*100
  until_level = levelSetting.thresold - totalExp

  return {until_percentage: until_percentage, until_level: until_level}
end
