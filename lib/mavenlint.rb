# frozen_string_literal: true

Dir[File.join(__dir__, 'rubocop/cop/mavenlint', '*.rb')].sort.each { |file| require file }
