require 'spec_helper'

describe Google::Webfonts::Helper do
  include Google::Webfonts::Helper
  
  def validate(tag, family)
    # should be a link tag
    tag.should =~ /<link.*\/>/
    
    # should include an href to the google webfonts api
    tag.should =~ /href="http:\/\/fonts.googleapis.com\/css\?family=/
    
    # should be a stylesheet
    tag.should =~ /rel="stylesheet"/
    
    # should be text/css
    tag.should =~ /type="text\/css"/
    
    # should include the expected font-family
    tag.should =~ /#{family}/
  end
  
  describe "#google_webfonts_link_tag" do
    
    context "with no arguments" do
      it "should raise ArgumentError" do
        expect { google_webfonts_link_tag }.to raise_error ArgumentError
      end
    end
    
    context "with something other than a String, Symbol, or Hash" do
      it "should raise ArgumentError" do
        expect { google_webfonts_link_tag(1) }.to raise_error ArgumentError
      end
    end
    
    context "when a size is something other than a String, or Fixnum" do
      it "should raise ArgumentError" do
        expect { google_webfonts_link_tag(:font => [:symbol]) }.to raise_error ArgumentError
      end
    end
    
    specify "with 1 font as a String" do
      validate google_webfonts_link_tag("hello"), "Hello"
    end
    
    specify "with 1 font as a Symbol" do
      validate google_webfonts_link_tag(:hello), "Hello"
    end
    
    specify "with multiple fonts as Strings" do
      validate google_webfonts_link_tag("hello", "world"), "Hello|World"
    end
    
    specify "with multiple fonts as a combination of Strings and Symbols" do
      validate google_webfonts_link_tag("hello", :world), "Hello|World"
    end
    
    context "with a Hash and 1 font name" do
      context "with a Symbol as the key" do
        specify "with 1 font size" do
          validate google_webfonts_link_tag(:hello => 100), "Hello:100"
        end
        
        specify "with 2 font sizes" do
          validate google_webfonts_link_tag(:hello => [100, 200]), "Hello:100,200"
        end
      end
      
      context "with a String as the key" do
        specify "with 1 font size" do
          validate google_webfonts_link_tag("hello" => 100), "Hello:100"
        end
        
        specify "with 2 font sizes" do
          validate google_webfonts_link_tag("hello" => [100, 200]), "Hello:100,200"
        end
      end
    end
    
    context "with a Hash and 2 font names" do
      context "with a Symbol as the key" do
        specify "with 1 font size" do
          validate google_webfonts_link_tag(:hello => 100, :world => 200), "Hello:100|World:200"
        end
        
        specify "with 2 font sizes" do
          validate google_webfonts_link_tag(:hello => [100, 200], :world => [300, 400]), "Hello:100,200|World:300,400"
        end
      end
      
      context "with a String as the key" do
        specify "with 1 font size" do
          validate google_webfonts_link_tag("hello" => 100, "world" => 200), "Hello:100|World:200"
        end
        
        specify "with 2 font sizes" do
          validate google_webfonts_link_tag("hello" => [100, 200], "world" => [300, 400]), "Hello:100,200|World:300,400"
        end
      end
    end
    
    context "when the font name includes an underscore" do
      it "should convert the underscore to a +" do
        validate google_webfonts_link_tag(:droid_sans => [400, 700]), 'Droid\+Sans:400,700'
      end
    end
    
    context "when the font name includes a space" do
      it "should conver the space to a +" do
        validate google_webfonts_link_tag("Droid Sans" => [400, 700]), 'Droid\+Sans:400,700'
      end
    end
    
    context "with a combination of all acceptable values" do
      it "should validate" do
        validate google_webfonts_link_tag(
          :font1, "font2", :font_3, "Font 4",
          :font_5   => 100,
          "font_6"  => [200, 300]
        ), 'Font1|Font2|Font\+3|Font\+4|Font\+5:100|Font\+6:200,300'
      end
    end
  end
  
end
