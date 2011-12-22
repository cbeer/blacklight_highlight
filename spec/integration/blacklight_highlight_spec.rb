require 'spec_helper'

describe 'Blacklight Highlighing' do
  it "should add :hl to the solr params" do
    parameters = CatalogController.new.solr_search_params({})
    parameters[:hl].should == true
  end
end
