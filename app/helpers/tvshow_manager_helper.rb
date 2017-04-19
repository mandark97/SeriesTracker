module TvshowManagerHelper
  def answer_test(answer)
    if (answer.is_a? Hash) && (answer[:response] == 'False') then
      false
    else
      true
    end
  end
end
