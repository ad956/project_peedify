import { Tabs } from 'expo-router';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import { useTheme } from 'react-native-paper';

export default function TabLayout() {
  const theme = useTheme();

  return (
    <Tabs
      screenOptions={{
        tabBarActiveTintColor: theme.colors.primary,
        tabBarInactiveTintColor: theme.colors.placeholder,
        tabBarStyle: {
          borderTopWidth: 1,
          borderTopColor: theme.colors.surfaceVariant,
          height: 60,
          paddingBottom: 8,
          paddingTop: 8,
        },
        headerStyle: {
          backgroundColor: theme.colors.primary,
        },
        headerTintColor: theme.colors.surface,
        headerTitleStyle: {
          fontWeight: 'bold',
        },
      }}>
      <Tabs.Screen
        name="index"
        options={{
          title: 'Home',
          tabBarIcon: ({ size, color }) => (
            <MaterialCommunityIcons name="home-variant" size={size} color={color} />
          ),
          headerTitle: 'Peedify',
        }}
      />
      <Tabs.Screen
        name="templates"
        options={{
          title: 'Templates',
          tabBarIcon: ({ size, color }) => (
            <MaterialCommunityIcons name="file-document-outline" size={size} color={color} />
          ),
          headerTitle: 'Invoice Templates',
        }}
      />
      <Tabs.Screen
        name="invoices"
        options={{
          title: 'Invoices',
          tabBarIcon: ({ size, color }) => (
            <MaterialCommunityIcons name="receipt" size={size} color={color} />
          ),
          headerTitle: 'My Invoices',
        }}
      />
    </Tabs>
  );
}