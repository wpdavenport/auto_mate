#  Should change this to a Capybara method

module AutoMateModule
  module Output
    def message(text, result)
      p "• #{text}: #{result}"
    end
  end
end