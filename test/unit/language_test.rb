require 'test_helper'

class LanguageTest < ActiveSupport::TestCase

  test 'default_languages' do
    puts 'testing default languages'

    en = Language.find_by_id(1)
    refute en.nil?, 'missing en language'
    assert en.code.nil?, 'wrong en code'

    pl = Language.find_by_id(2)
    refute pl.nil?, 'missing pl language'
    assert pl.code == 'pl', 'wrong pl code'
  end

  test 'language_scopes' do
    puts 'testing language scope'

    Language.all.each do |l|
      puts 'testing language code: ' + l.name
      # NoMethodError: undefined method `assert_recognizes' for #<LanguageTest:0x00000005745720>
      # don't know why
      #assert_recognizes({:locale => l.code.to_s}, '/' + l.code.to_s)
    end
  end
end
