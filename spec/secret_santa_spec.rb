require_relative '../secret_santa'

RSpec.describe 'SecretSanta' do
  let(:secret_santa) { SecretSanta.new(file_name: csv_file) }
  let(:csv_file) { '../secret_santa.csv' }

  describe '#shuffle' do
    subject { secret_santa.shuffle }

    context 'when CSV has odd number of members' do
      let(:csv_file) { './spec/fixtures/sample_odd.csv' }

      it 'always find a pair' do
        expect(subject.values).not_to include(nil)
        expect(subject.keys.sample).to be_a_kind_of(Person)
      end
    end

    context 'when CSV has even number of members' do
      let(:csv_file) { './spec/fixtures/sample_even.csv' }

      it 'always find a pair' do
        expect(subject.values).not_to include(nil)
        expect(subject.keys.sample).to be_a_kind_of(Person)
      end
    end

    context 'when CSV contains minimum number of participants' do
      let(:csv_file) { './spec/fixtures/sample_one_pair.csv' }

      it 'returns a pair' do
        expect(subject.values).not_to include(nil)
        expect(subject.keys.sample).to be_a_kind_of(Person)
      end
    end

    context 'when empty CSV' do
      let(:csv_file) { './spec/fixtures/empty.csv' }

      it 'returns no pair' do
        expect(subject.values).to be_empty
      end
    end
  end
end