import { Stack } from 'expo-router';
import UnderConstruction from '../components/UnderConstruction';

export default function NotFoundScreen() {
  return (
    <>
      <Stack.Screen options={{ headerShown: false }} />
      <UnderConstruction 
        title="Page Not Found" 
        message="The page you're looking for doesn't exist yet. We're working on it!" 
      />
    </>
  );
}
