require 'rspec'
require 'pry'

require_relative '../../processors/soccer_processor.rb'

describe SoccerProcessor do
  subject { SoccerProcessor.new(file_path) }

  describe 'validations' do
    context 'when the file wrappers are wrong' do
      let(:file_path) { 'spec/fixtures/files/wrong_wrap_soccer.dat' }

      it 'raises an error' do
        expect{ subject }.to raise_error(StandardError)
      end
    end

    context 'when the contents are empty' do
      let(:file_path) { 'spec/fixtures/files/empty_wrap_soccer.dat' }

      it 'raises an error' do
        expect{ subject }.to raise_error(StandardError)
      end
    end

    context 'when the file wrapper is correct' do
      let(:file_path) { 'spec/fixtures/files/soccer.dat' }

      it 'is happy' do
        expect{ subject }.to_not raise_error(StandardError)
      end
    end
  end

  describe '#smallest_delta' do
    let(:file_path) { 'spec/fixtures/files/soccer.dat' }

    it 'returns the expected line number' do
      expect(subject.smallest_delta).to eq('Aston_Villa')
    end
  end
end
