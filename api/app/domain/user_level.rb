def calc_user_level(user, totalExp)
  levelSetting = LevelSetting.find_by(level: user.level + 1)
  if levelSetting.present? && levelSetting.thresold <= user.experience_point
    totalExp -= levelSetting.thresold
    user.update(level: user.level += 1, experience_point: 0)
  end

  if user.level != 10
    until_percentage = totalExp.quo(levelSetting.thresold).to_f.round(2)*100
    until_level = levelSetting.thresold - totalExp
  end

  return {until_percentage: until_percentage, until_level: until_level}
end
