const userData = [
    { id: 1,name:"Hari", age: 25, gender: 'male', height: 180, bodyType: 'athletic', education: 'college', occupation: 'engineer', location: 'New York', interests: ['music', 'movies', 'sports'], dislikes: ['cats'] },
    { id: 2,name:"Pratiskhya", age: 28, gender: 'female', height: 165, bodyType: 'slim', education: 'graduate', occupation: 'teacher', location: 'Los Angeles', interests: ['books', 'travel'], dislikes: ['spicy food'] },
    { id: 3,name:"Sumit", age: 30, gender: 'male', height: 175, bodyType: 'average', education: 'college', occupation: 'doctor', location: 'Chicago', interests: ['sports', 'movies'], dislikes: ['horror movies'] },
    { id: 4,name:"Radha", age: 27, gender: 'female', height: 170, bodyType: 'athletic', education: 'graduate', occupation: 'engineer', location: 'New York', interests: ['music', 'travel'], dislikes: ['cats'] },
    { id: 5,name:"Anurag", age: 29, gender: 'male', height: 185, bodyType: 'average', education: 'graduate', occupation: 'doctor', location: 'Los Angeles', interests: ['sports', 'books'], dislikes: ['horror movies'] },
    { id: 6,name:"Anushka", age: 24, gender: 'female', height: 160, bodyType: 'slim', education: 'college', occupation: 'artist', location: 'New York', interests: ['painting', 'music', 'travel'], dislikes: ['spiders'] },
    { id: 7,name:"Sishir", age: 32, gender: 'male', height: 190, bodyType: 'muscular', education: 'graduate', occupation: 'lawyer', location: 'Chicago', interests: ['sports', 'photography'], dislikes: ['clowns'] },
    { id: 8,name:"Aaaiyena", age: 26, gender: 'female', height: 175, bodyType: 'average', education: 'college', occupation: 'writer', location: 'Los Angeles', interests: ['books', 'movies'], dislikes: ['snakes'] },
    { id: 9,name:"salipa", age: 31, gender: 'female', height: 170, bodyType: 'athletic', education: 'graduate', occupation: 'engineer', location: 'New York', interests: ['music', 'sports'], dislikes: ['horror movies'] },
    { id: 10,name:"abishek", age: 33, gender: 'male', height: 175, bodyType: 'average', education: 'college', occupation: 'teacher', location: 'Chicago', interests: ['books', 'movies'], dislikes: ['spiders'] },
  ];
  
  // Step 1: Calculate User Similarity
  function calculateSimilarity(user1, user2) {
    let similarity = 0;
  
    // Compare attributes like interests
    const commonInterests = user1.interests.filter((interest) => user2.interests.includes(interest));
    similarity += commonInterests.length;
  
    // Compare attributes like height
    const heightDifference = Math.abs(user1.height - user2.height);
    similarity += 10 - (heightDifference / 10);
  
    // Compare attributes like body type
    if (user1.bodyType === user2.bodyType) {
      similarity += 1;
    }
  
    // Compare attributes like education
    if (user1.education === user2.education) {
      similarity += 1;
    }
  
    // Compare attributes like occupation
    if (user1.occupation === user2.occupation) {
      similarity += 1;
    }
  
    // Compare attributes like location
    if (user1.location === user2.location) {
      similarity += 1;
    }
  
    return similarity;
  }
  
  // Step 2: Find Potential Partners
  function findPotentialPartners(targetUser, userData, similarityThreshold) {
    const potentialPartners = [];
  
    for (const user of userData) {
      if (user.id !== targetUser.id && user.gender !== targetUser.gender) {
        const similarity = calculateSimilarity(targetUser, user);
        if (similarity >= similarityThreshold) {
          potentialPartners.push(user);
        }
      }
    }
  
    return potentialPartners;
  }
  
  // Example usage
  const targetUser = userData[4]; // Assuming the target user is the first user in the data
  const similarityThreshold = 10; // Adjust the similarity threshold as desired
  
  const potentialPartners = findPotentialPartners(targetUser, userData, similarityThreshold);
  
  console.log("Potential Partners for:",targetUser.name, potentialPartners);