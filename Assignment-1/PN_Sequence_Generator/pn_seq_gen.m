function pn_sequence=generate_pn_sequence(n)
%function to generate PN sequence using an n-bit LFSR
%Input: n- length of the PN sequence
%output: pn_seq - generated PN sequence
%Initialize the LFST with a non-zero seed

lfsr=ones(1,n);
%lfsr=[1 0 0]

%Define the feed back polynomial
feedback_positions=[1,n];

%preallocate the PN sequence array
pn_sequence=zeros(1,2^n-1);

for i=1:2^n - 1
    %Get the output bit (the last bit of the LFSR)
    pn_sequence(i)=lfsr(end);
    
    feedback_bit=mod(sum(lfsr(feedback_positions)),2);
    lfsr = [feedback_bit, lfsr(1:end-1)];
end
end
%Example usage
n=3; % Number of bits in the LFSR
pn_sequence=generate_pn_sequence(n);
disp('Generated PN sequence');
disp(pn_sequence);
