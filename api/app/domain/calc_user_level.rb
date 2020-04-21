class CalcUserLevel
  def self.calc_user_level(user, totalExp)
    levelSetting = LevelSetting.find_by(level: user.level + 1)

    if levelSetting.present? && levelSetting.thresold <= user.experience_point
      totalExp -= levelSetting.thresold
      user.update(level: user.level += 1, experience_point: totalExp)

      levelSetting = LevelSetting.find_by(level: user.level + 1)
      # 次のレベルまでの値を返すために、参照するLevelSettingを１つ上にして変数に入れ直しています。
    end

    if user.level != 10
      # binding.pry
      until_percentage = totalExp.quo(levelSetting.thresold).to_f.round(2)*100
      until_level = levelSetting.thresold - totalExp
    end

    return {until_percentage: until_percentage, until_level: until_level}
  end
end
