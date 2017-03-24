require "spec_helper"

RSpec.describe RuboCop::Cop::Mavenlink::FixjourStyleFactories do
  subject(:cop) { described_class.new }

  before do
    inspect_source(cop, <<-EOS)
      create_example(name: 'This')
      new_sample(name: 'That')
      create_account_membership(name: 'This')
      new_record?
    EOS
  end

  it { expect(cop.offenses.size).to eq(2) }

  it { expect(cop.messages).to include("Use `create.a(:example, ...)` instead of `create_example(...)`.") }
  it { expect(cop.messages).to include("Use `build.a(:sample, ...)` instead of `new_sample(...)`.") }
  it { expect(cop.messages).to_not include("Use `create.a(:account_membership, ...)` instead of `create_account_membership(...)`.") }
  it { expect(cop.messages).to_not include("Use `build.a(:record?, ...` instead of `new_record?`.")}

  it { expect(cop.highlights).to include("create_example(name: 'This')") }
  it { expect(cop.highlights).to include("new_sample(name: 'That')") }
  it { expect(cop.highlights).to_not include("create_account_membership(name: 'This')") }
  it { expect(cop.highlights).to_not include("new_record?") }
end
