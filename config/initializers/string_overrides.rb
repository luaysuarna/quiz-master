class String
  def match_deep(value)
    first_value  = self.downcase
    second_value = value.downcase

    second_new_value = second_value.to_words_deep
    first_new_value  = first_value.to_words_deep

    jarow = FuzzyStringMatch::JaroWinkler.create( :native )
    first_arr  = first_new_value.split(" ")
    second_arr = second_new_value.split(" ")

    valid = []
    if first_arr.count == second_arr.count
      first_arr.each_with_index do |word, index|
        score = jarow.getDistance(word, second_arr[index])
        score >= 0.94 ? valid << true : valid << false
      end
    else
      valid << false
    end

    return valid.exclude? false
  end

  def to_words_deep
    words = self.split(" ").map do |word|
              value = word.to_i
              value > 0 ? value.to_words(remove_hyphen: true) : word
            end

    return words.join(" ")
  end
end