module TvshowManagerHelper
  def answer_test(answer)
    if answer.is_a? Hash and answer[:response] == 'False'
      return false
    else
      return true
    end
  end
end
