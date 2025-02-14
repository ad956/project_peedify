import { View, StyleSheet } from 'react-native';
import { Link } from 'expo-router';
import { LinearGradient } from 'expo-linear-gradient';
import { Text, Button, Surface } from 'react-native-paper';
import { MaterialCommunityIcons } from '@expo/vector-icons';
import Animated, { FadeInDown } from 'react-native-reanimated';

export default function HomeScreen() {
  return (
    <View style={styles.container}>
      <LinearGradient
        colors={['#007AFF', '#34C759']}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.header}>
        <Text variant="headlineLarge" style={styles.title}>
          Welcome to Peedify
        </Text>
        <Text variant="bodyLarge" style={styles.subtitle}>
          Invoice & Billing Made Simple
        </Text>
      </LinearGradient>

      <View style={styles.content}>
        <Animated.View entering={FadeInDown.delay(200)}>
          <Link href="/templates/create" asChild>
            <Surface style={styles.card} elevation={2}>
              <MaterialCommunityIcons
                name="file-plus-outline"
                size={48}
                color="#007AFF"
              />
              <Text variant="titleMedium" style={styles.cardTitle}>
                Create Template
              </Text>
              <Text variant="bodyMedium" style={styles.cardDescription}>
                Set up your business details and invoice structure
              </Text>
              <Button mode="contained" style={styles.button}>
                Get Started
              </Button>
            </Surface>
          </Link>
        </Animated.View>

        <Animated.View entering={FadeInDown.delay(400)}>
          <Link href="/invoices/create" asChild>
            <Surface style={styles.card} elevation={2}>
              <MaterialCommunityIcons
                name="receipt-text-plus"
                size={48}
                color="#34C759"
              />
              <Text variant="titleMedium" style={styles.cardTitle}>
                Generate Invoice
              </Text>
              <Text variant="bodyMedium" style={styles.cardDescription}>
                Create a new invoice using your templates
              </Text>
              <Button
                mode="contained"
                buttonColor="#34C759"
                style={styles.button}>
                Create New
              </Button>
            </Surface>
          </Link>
        </Animated.View>
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
  },
  header: {
    padding: 32,
    paddingTop: 48,
  },
  title: {
    color: '#FFFFFF',
    fontWeight: 'bold',
    marginBottom: 8,
  },
  subtitle: {
    color: '#FFFFFF',
    opacity: 0.9,
  },
  content: {
    flex: 1,
    padding: 16,
    gap: 16,
  },
  card: {
    padding: 24,
    borderRadius: 16,
    backgroundColor: '#FFFFFF',
    alignItems: 'center',
  },
  cardTitle: {
    marginTop: 16,
    marginBottom: 8,
    fontWeight: '600',
  },
  cardDescription: {
    textAlign: 'center',
    color: '#666666',
    marginBottom: 16,
  },
  button: {
    width: '100%',
  },
});