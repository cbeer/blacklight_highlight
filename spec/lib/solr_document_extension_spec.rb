require 'spec_helper'

describe BlacklightHighlight::SolrDocumentExtension do
  subject { SolrDocument.new :field => 'value' }

  describe "functional" do
    before do
      subject.stub(:highlight_fields => {
        'field' => ['<em>value</em>'],
        'other_field' => ['<em>ipsum</em> lorem']
      })
    end

    describe '#get' do
      it "should return the highlighted field" do
        val = subject.get('field', :separator => nil)
        val.should include('<em>value</em>')
        val.first.should be_html_safe
      end
    end

    describe "#key?" do
      it "should be true when a highlighted field is available" do
        subject.key?('other_field').should == true
      end
    end

    describe "#highlight" do
      it "should retrieve highlighted values from the solr response" do
        subject.highlight('field').should include('<em>value</em>')
      end

      it "should not try to look up the unique key value for highlighting" do
        subject.highlight('id').should be_nil
      end
    end
  end

  describe "#highlight_fields" do
    it "should be empty if no solr response is provided" do
      subject.highlight_fields.should be_a_kind_of(Hash)
      subject.highlight_fields.should be_empty
    end

    it "should use the RSolr::Ext highlighting extension to get highlighted values" do
      @mock_solr_response = mock()
      @mock_solr_response.should_receive(:respond_to?).with(:highlight) { true }
      @mock_solr_response.should_receive(:highlight)
      subject.stub(:solr_response => @mock_solr_response)
      subject.highlight_fields
    end
  end


end
