import random

def generate_challenges(num_challenges, challenge_length):
    challenges=[]
    hex_length = challenge_length // 4  # Convert bit length to hex length
    for i in range(num_challenges):
         challenges.append(format(random.getrandbits(challenge_length), f'0{hex_length}X') )
              
    return challenges

def save_challenges_to_file(challenges, file_path):

    counter=0
    with open(file_path, 'w') as file:
       # print(len(challenges)//200)
        
            file.write('{')
            for challenge in challenges:
                counter+=1
                file.write('0x'+challenge+',' + '\n')
                if counter==400:
                    counter=0
                    file.write('}')
                    file.write('{')
                
            file.write('}')

def check_random(challenges):
    for i in range(0,len(challenges)-1):
        if challenges.count(challenges[i])>1:
            print("found one")
            return
    print("everything is good")
    
def generate_challenges_2(num_challenges, challenge_length):

    hex_length = challenge_length // 4  # Convert bit length to hex length
    half_hex_length = hex_length // 2  # Split into two 64-bit halves

    challenge_final_array = []

    for i in range(num_challenges):
            full_challenge = format(random.getrandbits(challenge_length), f'0{hex_length}X') 
            challenge1 = full_challenge[:half_hex_length]  
            challenge2= full_challenge[half_hex_length:]
            challenge_final_array.append(challenge1)
            challenge_final_array.append(challenge2)
    
    return challenge_final_array




def main():
    num_challenges = 100000  # Number of challenges to generate
    challenge_length = 128  # Length of each challenge in bits (e.g., 32 bits)

    # Generate random challenges
    if challenge_length>=128:
        challenge_array = generate_challenges_2(num_challenges, challenge_length)
        save_challenges_to_file(challenge_array, '128_bit_challenges_part1.txt')
  #      save_challenges_to_file(challenge_array_2, '128_bit_challenges_part2.txt')
    else:
        challenges = generate_challenges(num_challenges, challenge_length)
  #  check_random(challenges)
        save_challenges_to_file(challenges, '64_bit_challenges.txt')
    print(f"Generated {num_challenges} hexadecimal challenges and saved to challenges.txt")
    


if __name__ == "__main__":
    main()




