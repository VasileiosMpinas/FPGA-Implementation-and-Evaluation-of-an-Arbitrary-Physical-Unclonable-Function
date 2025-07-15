import numpy as np

def hex_to_bin(hex_str,bit_fill):
    # Remove 0x and convert to binary (pad to 64 bits)
    binary_str = bin(int(hex_str[2:], 16))[2:].zfill(bit_fill)
    return binary_str

def calculate_uniformity(responses):
    uniformity = []
    for r in responses:
        total_bits = len(r)
        ones_count = r.count('1')
        u = (ones_count / total_bits) 
        uniformity.append(u)
    total_uniformity = (sum(uniformity) / len(uniformity)) * 100
    return total_uniformity

def calculate_uniqueness_old(responses):
    n = len(responses)
    total_hd = 0
    total_comparisons = 0
    l = len(responses[0])  # Length of each response (64)


    # Pairwise comparison of all responses
    for i in range(n):
        for j in range(i + 1, n):
            hd = sum(a != b for a, b in zip(responses[i], responses[j]))
            total_hd += hd
            total_comparisons += 1

    # Normalize by total bits
    uniqueness = (total_hd / (total_comparisons * l)) * 100
    return uniqueness




def calculate_uniqueness(responses, segment_length):
    n = len(responses)
    l = len(responses[0])  # Total length of each response (e.g., 64 bits)
    
    # Ensure segment length divides response length evenly
    if l % segment_length != 0:
        raise ValueError("Segment length must evenly divide response length.")

    num_segments = l // segment_length  # Total segments per response
    total_hd = 0
    total_comparisons = 0

    # Iterate over each segment position
    for seg in range(num_segments):
        # Extract the segment from each response
        segments = []
        for response in responses:
            segment = response[seg * segment_length : (seg + 1) * segment_length]
            segments.append(segment)

        # Pairwise comparison of segments
        for i in range(n):
            for j in range(i + 1, n):
                hd = sum(a != b for a, b in zip(segments[i], segments[j]))
                total_hd += hd
                total_comparisons += segment_length

    # Normalize by total bits compared
    uniqueness = (total_hd / (total_comparisons)) * 100
    return uniqueness




def check_random(responses):
 #   print(len(responses))
    for i in range(0,len(responses)-1):
       # print(responses[i])
       for j in range(i+1,len(responses)-1):
            if responses[i]== responses[j]:
                print("found one")
                print(responses[i],responses[j])
                print(i)
                print('line:',j)
                
           # print(responses[i],responses[j])
    print("everything is good")
    return


def save_to_file(challenges, file_path):
    """
    Save generated challenges to a text file.
    :param challenges: List of challenges.
    :param file_path: Path to save the challenges.
    """
    counter=0
    with open(file_path, 'w') as file:
       # print(len(challenges)//200)
        
            for challenge in challenges:
                file.write(challenge + '\n')
                

def process_responses(filename,bit_fill):
    with open(filename, 'r') as file:
        # Read and process each line (hex to binary)
        responses = [hex_to_bin(line.strip(),bit_fill) for line in file if line.strip()]

        print(len(responses))
    
    uniformity = calculate_uniformity(responses) #[calculate_uniformity(responses) for r in responses]
 #   overall_uniformity = sum(uniformity_results) / len(uniformity_results)

   #Uniqueness across responses
    uniqueness = calculate_uniqueness(responses,4)

    # Print results
    print(f"Average Uniformity: {uniformity:.2f}%")
    print(f"Uniqueness: {uniqueness:.2f}%")

# Call the function with your txt file

#process_responses('64_bit_new.txt',64)

#process_responses('32_ch_32_resp_3.txt',32)
process_responses('64_ch_64_resp_4.txt',64)
#process_responses('test2.txt',32)

print("32-32 with xor")
process_responses('32_ch_32_resp_1.txt',32)

print("64-32 without xor")
process_responses('64_ch_32_resp_2.txt',32)


print("4-4 with xor")
process_responses('4_ch_4_resp_1.txt',4)
print("4-4 without xor")
process_responses('4_ch_4_resp_2.txt',4)

print("8-8 with xor")
process_responses('8_ch_8_resp_1.txt',8)
print("8-8 without xor")
process_responses('8_ch_8_resp_2.txt',8)

print("16-16 with xor")
process_responses('16_ch_16_resp_1.txt',16)
print("16-16 without xor")
process_responses('16_ch_16_resp_2.txt',16)

print("32-32 with xor")
process_responses('32_ch_32_resp_1.txt',32)
print("32-32 without xor")
process_responses('32_ch_32_resp_2.txt',32)

print("32-64 with xor")
process_responses('32_ch_64_resp_1.txt',64)
print("32-64 without xor")
process_responses('32_ch_64_resp_2.txt',64)

print("64-32 with xor")
process_responses('64_ch_32_resp_1.txt',32)
print("64-32 without xor")
process_responses('64_ch_32_resp_2.txt',32)

print("64-64 with xor")
process_responses('64_ch_64_resp_1.txt',64)
print("64-64 without xor")
process_responses('64_ch_64_resp_2.txt',64)

print("64-128 without xor")
process_responses('64_ch_128_resp_2.txt',128)

print("128-64 without xor")
process_responses('128_ch_64_resp_2.txt',64)
