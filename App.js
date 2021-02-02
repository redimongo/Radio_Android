import * as React from 'react';
import { Text, View, StyleSheet, Button } from 'react-native';
import { Audio } from 'expo-av';

export default function App() {
  const [sound, setSound] = React.useState();

  async function playSound() {
    console.log('Loading Sound');
    const sound = new Audio.Sound();
    try {
      await sound.loadAsync({uri: 'http://stream.radiomedia.com.au:8003/stream'});
      await sound.playAsync();
      // Your sound is playing!
    
      // Don't forget to unload the sound from memory
      // when you are done using the Sound object
     // await sound.unloadAsync();
    } catch (error) {
      // An error occurred!
      print(error)
    }
    setSound(sound);

    console.log('Playing Sound');
    await sound.playAsync(); }

  React.useEffect(() => {
    return sound
      ? () => {
          console.log('Unloading Sound');
          sound.unloadAsync(); }
      : undefined;
  }, [sound]);

  return (
    <View>
      <Button title="Play Sound" onPress={playSound} />
    </View>
  );
}