import { Stack } from 'expo-router';
import { StatusBar } from 'expo-status-bar';

export default function RootLayout() {
  return (
    <>
      <StatusBar style="light" backgroundColor="#0f0f23" />
      <Stack
        screenOptions={{
          headerShown: false,
          contentStyle: { backgroundColor: '#0f0f23' },
        }}
      >
        <Stack.Screen name="(tabs)" />
        <Stack.Screen name="under-construction" />
        <Stack.Screen name="post-property" />
        <Stack.Screen name="ai-assistant" />
        <Stack.Screen name="+not-found" />
      </Stack>
    </>
  );
}