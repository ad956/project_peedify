import { useState } from 'react';
import {
  View,
  Text,
  StyleSheet,
  TextInput,
  TouchableOpacity,
  ScrollView,
  Alert,
} from 'react-native';
import { router } from 'expo-router';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Ionicons } from '@expo/vector-icons';
import { Template } from '../../types';

export default function CreateTemplateScreen() {
  const [businessName, setBusinessName] = useState('');
  const [address, setAddress] = useState('');
  const [phone, setPhone] = useState('');
  const [email, setEmail] = useState('');
  const [columns, setColumns] = useState<string[]>(['Description', 'Quantity', 'Rate', 'Amount']);
  const [newColumn, setNewColumn] = useState('');

  const addColumn = () => {
    if (newColumn.trim()) {
      setColumns([...columns, newColumn.trim()]);
      setNewColumn('');
    }
  };

  const removeColumn = (index: number) => {
    setColumns(columns.filter((_, i) => i !== index));
  };

  const saveTemplate = async () => {
    if (!businessName || !address || !phone || !email) {
      Alert.alert('Error', 'Please fill in all business details');
      return;
    }

    if (columns.length < 2) {
      Alert.alert('Error', 'Please add at least two columns');
      return;
    }

    const template: Template = {
      id: Date.now().toString(),
      businessName,
      address,
      phone,
      email,
      columns,
    };

    try {
      const existingTemplates = await AsyncStorage.getItem('templates');
      const templates = existingTemplates ? JSON.parse(existingTemplates) : [];
      await AsyncStorage.setItem(
        'templates',
        JSON.stringify([...templates, template])
      );
      router.back();
    } catch (error) {
      Alert.alert('Error', 'Failed to save template');
    }
  };

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>Create Invoice Template</Text>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Business Details</Text>
        <TextInput
          style={styles.input}
          placeholder="Business Name"
          value={businessName}
          onChangeText={setBusinessName}
        />
        <TextInput
          style={styles.input}
          placeholder="Address"
          value={address}
          onChangeText={setAddress}
          multiline
        />
        <TextInput
          style={styles.input}
          placeholder="Phone Number"
          value={phone}
          onChangeText={setPhone}
          keyboardType="phone-pad"
        />
        <TextInput
          style={styles.input}
          placeholder="Email"
          value={email}
          onChangeText={setEmail}
          keyboardType="email-address"
          autoCapitalize="none"
        />
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Invoice Columns</Text>
        <View style={styles.columnList}>
          {columns.map((column, index) => (
            <View key={index} style={styles.columnItem}>
              <Text style={styles.columnText}>{column}</Text>
              <TouchableOpacity
                onPress={() => removeColumn(index)}
                style={styles.removeButton}>
                <Ionicons name="close-circle" size={20} color="#FF3B30" />
              </TouchableOpacity>
            </View>
          ))}
        </View>
        <View style={styles.addColumnContainer}>
          <TextInput
            style={styles.columnInput}
            placeholder="New Column Name"
            value={newColumn}
            onChangeText={setNewColumn}
          />
          <TouchableOpacity onPress={addColumn} style={styles.addButton}>
            <Ionicons name="add" size={24} color="#FFF" />
          </TouchableOpacity>
        </View>
      </View>

      <TouchableOpacity onPress={saveTemplate} style={styles.saveButton}>
        <Text style={styles.saveButtonText}>Save Template</Text>
      </TouchableOpacity>
    </ScrollView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
    padding: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: 'bold',
    color: '#000',
    marginBottom: 24,
  },
  section: {
    marginBottom: 24,
  },
  sectionTitle: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000',
    marginBottom: 16,
  },
  input: {
    backgroundColor: '#FFF',
    padding: 12,
    borderRadius: 8,
    marginBottom: 12,
    fontSize: 16,
  },
  columnList: {
    gap: 8,
    marginBottom: 16,
  },
  columnItem: {
    backgroundColor: '#FFF',
    padding: 12,
    borderRadius: 8,
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  columnText: {
    fontSize: 16,
    color: '#000',
  },
  removeButton: {
    padding: 4,
  },
  addColumnContainer: {
    flexDirection: 'row',
    gap: 8,
  },
  columnInput: {
    flex: 1,
    backgroundColor: '#FFF',
    padding: 12,
    borderRadius: 8,
    fontSize: 16,
  },
  addButton: {
    backgroundColor: '#007AFF',
    width: 48,
    height: 48,
    borderRadius: 24,
    alignItems: 'center',
    justifyContent: 'center',
  },
  saveButton: {
    backgroundColor: '#007AFF',
    padding: 16,
    borderRadius: 12,
    alignItems: 'center',
    marginTop: 24,
    marginBottom: 40,
  },
  saveButtonText: {
    color: '#FFF',
    fontSize: 16,
    fontWeight: '600',
  },
});