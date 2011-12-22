require 'spec_helper'

describe 'Blacklight Highlighing' do
  it "should add :hl to the solr params" do
    parameters = CatalogController.new.solr_search_params({:q => 'asdf'})
    parameters[:hl].should == true
  end

  it "should not add :hl to the solr params if no :q param is given" do
    parameters = CatalogController.new.solr_search_params({})
    parameters[:hl].should_not == true
  end
end
