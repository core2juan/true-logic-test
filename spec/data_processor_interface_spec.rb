require 'rspec'
require 'pry'

require_relative '../data_processor_interface.rb'

describe DataProcessorInterface do

  subject { DataProcessorInterface.new(type: type, file_path: file_path) }

  describe 'validations' do
    let(:file_path) { 'spec/fixtures/files/soccer.dat' }
    let(:type) { :not_valid }

    context 'when the type is not valid' do
      it 'raises an error' do
        expect{ subject }.to raise_error(StandardError)
      end
    end

    context 'when the file is not present' do
      let(:file_path) { 'unknown_file.dat' }
      let(:type) { :soccer }

      it 'raises an error' do
        expect{ subject }.to raise_error(StandardError)
      end
    end
  end

  describe '#run' do
    context 'when the processor is soccer' do
      let(:file_path) { 'spec/fixtures/files/soccer.dat' }
      let(:type) { :soccer }

      it 'returns the expected output' do
        expect(subject.run).to eq('Aston_Villa')
      end
    end

    context 'when the processor is temperature' do
      let(:file_path) { 'spec/fixtures/files/w_data.dat' }
      let(:type) { :temperature }

      it 'returns the expected output' do
        expect(subject.run).to eq('14')
      end
    end
  end
end
