describe "SugarCube::Anonymous" do

  before do
    @h = SugarCube::Anonymous[{ foo: 'FOO', "bar" => 'BAR' }]
  end

  describe "NSDictionary#to_object" do

    it 'should return an instance of SugarCube::Anonymous' do
      SugarCube::Anonymous.should === { foo: 'FOO', "bar" => 'BAR' }.to_object
    end

  end

  describe "constructor" do

    it 'should give an instance of SugarCube::Anonymous' do
      SugarCube::Anonymous.should === @h
    end

  end

  describe "getter" do

    it 'should have an #foo method, and return "FOO"' do
      @h.foo.should == 'FOO'
    end

    it 'should have an #bar method, and return "BAR"' do
      @h.bar.should == 'BAR'
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) {
        @h.hoge
      }
    end

  end

  describe "setter" do

    it 'should have an #foo= method, and return "Foo"' do
      @h.foo = 'Foo'
      @h.foo.should == 'Foo'
    end

    it 'should have a #bar= method, and return "Bar"' do
      @h.bar = 'Bar'
      @h.bar.should == 'Bar'
    end

    it 'should raise NoMethodError on non-existing keys' do
      should.raise(NoMethodError) {
        @h.hoge.should == 'Hoge'
      }
    end

  end

end


describe "SugarCube::Anonymous nested case" do

  before do
    @h = SugarCube::Anonymous[
      {
        dictionary: { foo: 'FOO', array: [ { is_fine: 'is_fine' } ] },
        array: [ { bar: 'BAR' }, [ 1, 2, 3 ] ]
      }
    ]
  end
  
  describe "dictionary" do
  
    it 'should return an instance of SugarCube::Anonymous' do
      @h.dictionary.class.should == SugarCube::Anonymous
    end
    
    it 'should return a hash which contains a string and an array' do
      @h.dictionary.should == { foo: 'FOO', array: [ { is_fine: 'is_fine' } ] }
    end
    
    it 'should not copy again' do
      @h.dictionary.object_id.should == @h.dictionary.object_id
    end
    
    it 'should return is_fine' do
      @h.dictionary.array[0].is_fine.should == 'is_fine'
    end
    
  end

  describe "array" do
  
    it 'should return an instance of SugarCube::AnonymousArray' do
      @h.array.class.should == SugarCube::AnonymousArray
    end
    
    it 'should not copy again' do
      @h.array.object_id.should == @h.array.object_id
    end
      
    describe "inner object" do
    
      it 'should return an instance of SugarCube::Anonymous' do
        @h.array[0].class.should == SugarCube::Anonymous
      end
      
      it 'should return an instance of SugarCube::Anonymous' do
        @h.array.first.class.should == SugarCube::Anonymous
      end
      
      it 'should return an instance of SugarCube::AnonymousArray' do
        @h.array[1].class.should == SugarCube::AnonymousArray
      end
      
      it 'should return an instance of SugarCube::AnonymousArray' do
        @h.array.last.class.should == SugarCube::AnonymousArray
      end
      
    end

  end

end
