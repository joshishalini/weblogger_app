require 'pry'

require_relative '../lib/parser'

RSpec.describe Parser do
  subject(:parser) { described_class.new(path) }

  context "When no file present" do
    let(:path) { '../no_webserver.log' }

    it "raises an error" do
      expect { parser }.to raise_error(RuntimeError, "File not present.")
    end 
  end

  context "When file present" do
    let(:path) { 'spec/fixtures/webserver_test1.log' }

    it "Does not raises an error" do
      expect { parser }.not_to raise_error(RuntimeError, "File not present.")
    end 
  end

  context "When file present" do
    let(:path) { 'spec/fixtures/no_webserver.log' }

    it "Does raises an error for wrong file" do
      parser
      expect { parser.parse }.not_to raise_error(RuntimeError, "Wrong file.")
    end 
  end

  describe '#parse' do
    before do
      parser
      parser.parse
    end

    context "With test 1 log" do
      let(:path) { 'spec/fixtures/webserver_test1.log' }

      let(:expected_results) do
        {
          '/help_page/1'   => {:ip=>["126.318.035.038", "929.398.951.889", "722.247.931.582"], :count=>4},
          '/contact' => {:ip=>["184.123.665.067"], :count=>1},
          '/home'   => {:ip=>["184.123.665.067", "235.313.352.950"], :count=>2},
          '/about/2' => {:ip=>["444.701.448.104"], :count=>1},
          '/index'    => {:ip=>["444.701.448.104"], :count=>1},
          '/about' => {:ip=>["061.945.150.735"], :count=>1}
        }
      end

      it "parses the data correctly" do
        expect(parser.data).to eq(expected_results)
      end
    end

    context "With websever test 2 file"do
      let(:path) { 'spec/fixtures/webserver_test2.log' }

      let(:expected_results) do
        {
          '/contact'   => {:ip=>["158.577.775.616", "126.318.035.038"], :count=>2},
          '/about' => {:ip=>["802.683.925.780"], :count=>2},
          '/about/2'   => {:ip=>["543.910.244.929", "184.123.665.067", "200.017.277.774"], :count=>3},
          '/help_page/1' => {:ip=>["200.017.277.774"], :count=>1},
          '/home'    => {:ip=>["126.318.035.038", "451.106.204.921", "200.017.277.774"], :count=>3}
        }
      end

      it "parses the data correctly" do
        expect(parser.data).to eq(expected_results)
      end
    end
  end

  describe '#unique_pages' do
    context "With test 1 log" do
      let(:path) { 'spec/fixtures/webserver_test1.log' }

      before do
        parser
        parser.parse
      end

      let(:expected_results) do
        [["/help_page/1", {:count=>4, :ip=>["126.318.035.038", "929.398.951.889", "722.247.931.582"]}],
          ["/home", {:count=>2, :ip=>["184.123.665.067", "235.313.352.950"]}],
          ["/about", {:count=>1, :ip=>["061.945.150.735"]}],
          ["/index", {:count=>1, :ip=>["444.701.448.104"]}],
          ["/about/2", {:count=>1, :ip=>["444.701.448.104"]}],
          ["/contact", {:count=>1, :ip=>["184.123.665.067"]}]
        ]
      end

      it 'returns the correct values' do
        expect(parser.unique_pages).to eq(expected_results)
      end
    end

    context "With test 3 log" do
      let(:path) { 'spec/fixtures/webserver_test3.log' }
      before do
        parser
        parser.parse
      end

      let(:expected_results) do
        [
          ["/about", {:count=>2, :ip=>["802.683.925.78", "802.683.925.780"]}],
          ["/contact", {:count=>2, :ip=>["158.577.775.616", "126.318.035.038"]}],
          ["/home", {:count=>5, :ip=>["126.318.035.038"]}]
        ]
      end

      it 'returns the correct values' do
        expect(parser.unique_pages).to eq(expected_results)
      end
    end
  end

  describe '#most_visited_pages' do
    context "With test 1 log" do
      let(:path) { 'spec/fixtures/webserver_test1.log' }
      before do
        parser
        parser.parse
      end

      let(:expected_results) do
        [
          ["/help_page/1", {:count=>4, :ip=>["126.318.035.038", "929.398.951.889", "722.247.931.582"]}],
          ["/home", {:count=>2, :ip=>["184.123.665.067", "235.313.352.950"]}],
          ["/about", {:count=>1, :ip=>["061.945.150.735"]}],
          ["/index", {:count=>1, :ip=>["444.701.448.104"]}],
          ["/about/2", {:count=>1, :ip=>["444.701.448.104"]}],
          ["/contact", {:count=>1, :ip=>["184.123.665.067"]}]
        ]
      end

      it 'returns the correct values' do
        expect(parser.most_visited_pages).to eq(expected_results)
      end
    end

    context "With test 3 log" do
      let(:path) { 'spec/fixtures/webserver_test3.log' }
      before do
        parser
        parser.parse
      end

      let(:expected_results) do
        [
          ["/home", {:count=>5, :ip=>["126.318.035.038"]}],
          ["/about", {:count=>2, :ip=>["802.683.925.78", "802.683.925.780"]}],
          ["/contact", {:count=>2, :ip=>["158.577.775.616", "126.318.035.038"]}]
        ]
      end

      it 'returns the correct values' do
        expect(parser.most_visited_pages).to eq(expected_results)
      end
    end
  end
end