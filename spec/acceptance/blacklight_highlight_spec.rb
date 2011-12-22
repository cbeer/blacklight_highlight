require 'spec_helper'

describe 'Blacklight highlighting' do
  use_vcr_cassette "solr"
  before do
    CatalogController.configure_blacklight do |config|
      config.index.show_link = 'title_display'
      config.default_solr_params = {
        :per_page => 10
      }

      config.add_index_field 'field'
      config.add_index_field 'highlight_field', :highlight => true
    end
  end

  it "" do
    visit '/'
    fill_in 'q', :with => 'ipsum lorem'
    click_button 'search'

    page.should_not have_content 'Lorem ipsum'
    page.should have_content 'lorem et lorem'
  end
end
