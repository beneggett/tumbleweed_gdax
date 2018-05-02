# frozen_string_literal: true

class Bot
  class << self
    def log(phrase, data = nil, log_level = :info)
      # :nocov:
      unless Rails.env == 'test'
        Rails.logger.send log_level, phrase
        Rails.logger.send log_level, Rainbow(data).green if data
      end
      # :nocov:
    end

    def saying
      [
        "Mo money, mo problems",
        "Cha Ching",
        "uh,huh.",
        "Yeaah",
        "Yessir",
        "Boooooo yeah",
        "Woooop Woooop",
        "aww shit",
        "Damn son",
        "Yo Yo Yo",
        "Hey crypto king",
      ].sample
    end

    def sleep(secs)
      Kernel.sleep(secs)
    end

    # :nocov:
    def mantra
      mantra_spacer
      mantra_1
      mantra_spacer
      mantra_2
      mantra_spacer
      mantra_3
      mantra_spacer
      mantra_4
      mantra_spacer
    end

    def mantra_spacer
      puts "\n"
    end

    def mantra_1
      puts "'|.   '|'          ||    .   '||                                ".cyan
      puts " |'|   |    ....  ...  .||.   || ..     ....  ... ..      ....  ".cyan
      puts " | '|. |  .|...||  ||   ||    ||' ||  .|...||  ||' ''    '' .|| ".cyan
      puts " |   |||  ||       ||   ||    ||  ||  ||       ||        .|' || ".cyan
      puts ".|.   '|   '|...' .||.  '|.' .||. ||.  '|...' .||.       '|..'|'".cyan
    end

    def mantra_2
      puts "'||                                                                 ".cyan
      puts " || ...    ...   ... ..  ... ..    ...   ... ... ...   ....  ... .. ".cyan
      puts " ||'  || .|  '|.  ||' ''  ||' '' .|  '|.  ||  ||  |  .|...||  ||' ''".cyan
      puts " ||    | ||   ||  ||      ||     ||   ||   ||| |||   ||       ||    ".cyan
      puts " '|...'   '|..|' .||.    .||.     '|..|'    |   |     '|...' .||.   ".cyan
    end

    def mantra_3
      puts ".. ...     ...   ... ..      ....  ".cyan
      puts " ||  ||  .|  '|.  ||' ''    '' .|| ".cyan
      puts " ||  ||  ||   ||  ||        .|' || ".cyan
      puts ".||. ||.  '|..|' .||.       '|..'|'".cyan
    end

    def mantra_4
      puts "'||                        '||                     '||             ".cyan
      puts " ||    ....  .. ...      .. ||    ....  ... ..      || ...    .... ".cyan
      puts " ||  .|...||  ||  ||   .'  '||  .|...||  ||' ''     ||'  || .|...||".cyan
      puts " ||  ||       ||  ||   |.   ||  ||       ||         ||    | ||     ".cyan
      puts ".||.  '|...' .||. ||.  '|..'||.  '|...' .||.        '|...'   '|...'".cyan
    end
    # :nocov:
  end
end
