require 'minitest/autorun'
require_relative '../lib/rosalind'

describe Rosalind::DNA do
  before do
    @empty_dna = Rosalind::DNA.new
    @short_dna = Rosalind::DNA.new('ACGT') # Is it's own reverse complement.
    @sample_rna = Rosalind::RNA.new('AGCUUUUCAUUCUGACUGCAACGGGCAAUAUGUCUCUGUGUGGAUUAAAAAAAGAGUGUCUGAUAGCAGC')
    @sample_dna = Rosalind::DNA.new('AGCTTTTCATTCTGACTGCAACGGGCAATATGTCTCTGTGTGGATTAAAAAAAGAGTGTCTGATAGCAGC')
    @sample_reverse_complement = Rosalind::DNA.new('GCTGCTATCAGACACTCTTTTTTTAATCCACACAGAGACATATTGCCCGTTGCAGTCAGAATGAAAAGCT')
    @medium_string_1   = Rosalind::DNA.new('GAGCCTACTAACGGGAT')
    @medium_string_2   = Rosalind::DNA.new('CATCGTAATGACGGCCT')
    @medium_string_3   = Rosalind::DNA.new('GATATATGCATATACTT')
  end
  
  describe "when asked for its class" do
    it "must response with DNA" do
      @empty_dna.class.must_equal Rosalind::DNA
      @short_dna.class.must_equal Rosalind::DNA
    end
  end
  
  describe "when initialized with Rosalind 'dna' sample dataset" do
    it "must generate the correct ASCII count output" do
      @sample_dna.ASCII_base_count.must_equal "20 12 17 21"
    end
    it "must be able to convert to the correct reverse complement" do
      reverse_complement = @sample_dna.to_reverse_complement
      reverse_complement.must_equal @sample_reverse_complement
    end
  end
  
  describe "when transcribing to RNA" do
    it "must be able to convert to a RNA object" do
      rna_from_dna = @sample_dna.to_rna
      rna_from_dna.class.must_equal Rosalind::RNA
    end
    it "must convert to RNA correctly" do
      rna_from_dna = @sample_dna.to_rna
      rna_from_dna.must_equal @sample_rna
    end
    it "must be able to convert back to original DNA" do
      @sample_dna.to_rna.to_dna.must_equal @sample_dna
    end
  end
  
  describe "when initialized with 'ACGT'" do
    it "must be it's own reverse complement" do
      @short_dna.to_reverse_complement.must_equal @short_dna
    end
  end
  
    describe "when searching for the longest common substring" do
    it "must find the correct substring amongst three sequences" do
      longest_common_substring = Rosalind::Sequence.longest_common_substring([@medium_string_1, @medium_string_2, @medium_string_3])
      longest_common_substring.must_equal Rosalind::DNA.new('GA')
    end
    it "must return a substring of the correct type (DNA)" do
      longest_common_substring = Rosalind::Sequence.longest_common_substring([@medium_string_1, @medium_string_2, @medium_string_3])
      longest_common_substring.class.must_equal Rosalind::DNA
    end
  end
end