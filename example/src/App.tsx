import * as React from 'react';

import { useState } from 'react';
import { StyleSheet, View, Text, Button } from 'react-native';
import { AuthorizationStatus, askPermissions, getCurrentStatus } from 'rn-tester-library';

export default function App() {

  const [currentState, setCurrentState] = useState<AuthorizationStatus>('Unknown');

  React.useEffect(() => {
    async function setInitialState() {
      let newState = await getCurrentStatus();
      setCurrentState(newState)
    }
    setInitialState()
  }, [])

  return (
    <View style={styles.container}>
      <Button title="Ask Permissions" onPress={async () => {
        let newState = await askPermissions();
        setCurrentState(newState)
      }} />
      <View>
        <Text>Authorization status: {currentState}</Text>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
  },
  box: {
    width: 60,
    height: 60,
    marginVertical: 20,
  },
});
