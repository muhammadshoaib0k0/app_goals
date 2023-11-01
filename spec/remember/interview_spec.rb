$count_let = 0
describe "let" do # I want to be its fails because of learning the concept.
  let(:count_let) { $count_let += 1 }

  it "returns 1" do # please uncomment i commented bc of the github action 
    # expect($count_let).to eq(1) # Its fail because we never be instantiated let(:count_let) and don't call it
  end
end

# now $count_let_bang returns 1, thus test got passed. It happened as I used let!, 
# which run before the example run, although we didn't invoke count_let_bang inside our example.

$count_let_bang = 0
describe "let!" do
  let!(:count_let_bang) { $count_let_bang += 1 }

  it "returns 1" do
      expect($count_let_bang).to eq(1)
  end
end

# (:let) is lazily evaluated and will never be instantiated if you don't call it, while (:let!) is forcefully evaluated before each method call.


describe 'GetTime' do
  let(:current_time) { Time.now }

  it "gets the same time over and over again" do
    puts current_time # => same time
    sleep(3)
    puts current_time # => same time
  end

  it "gets the time again" do
    puts current_time # => same time + 3 sec
  end
end

# Lazy evaluation means the let block runs only if and when it is referenced
describe "GetTime with before" do
  let(:current_time) { Time.now }

  before(:each) do
    puts Time.now # =>  time 
  end

  it "gets the time" do
    sleep(3)
    puts current_time # => time + 3 sec
  end
end

# You can use let! to force the method’s invocation before each example.

describe "GetTime with bang and before" do
  let!(:current_time) { Time.now }

  before(:each) do
    puts Time.now # => same
  end

  it "gets the time" do
    sleep(3)
    puts current_time # => same its does not add 3 second delay to the time
  end
end

# This behavior is useful when you need to set some state before the it block runs.
