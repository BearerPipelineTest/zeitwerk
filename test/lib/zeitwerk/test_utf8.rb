# frozen_string_literal: true

require "test_helper"

class TestUTF8 < LoaderTest
  test "autoloads constants that have accented letters in the middle" do
    files = [["màxim.rb", "Màxim = true"]]
    with_setup(files) do
      assert Màxim
    end
  end

  unless RUBY_VERSION.start_with?("2.5.")
    test "autoload constants that start with the Greek letter Omega" do
      files = [["ω.rb", "Ω = true"]]
      with_setup(files) do
        assert Ω
      end
    end

    test "autoloads implicit namespaces conisting of Greek letters" do
      files = [["διαχειριστής/χρήστης.rb", "Διαχειριστής::Χρήστης = true"]]
      with_setup(files) do
        assert Διαχειριστής::Χρήστης
      end
    end

    test "autoloads explicit namespaces conisting of Greek letters" do
      files = [
        ["διαχειριστής.rb", "module Διαχειριστής; end"],
        ["διαχειριστής/χρήστης.rb", "Διαχειριστής::Χρήστης = true"]
      ]
      with_setup(files) do
        assert Διαχειριστής::Χρήστης
      end
    end
  end
end
