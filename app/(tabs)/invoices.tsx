import { View, Text, StyleSheet, FlatList, TouchableOpacity } from 'react-native';
import { Link } from 'expo-router';
import { Ionicons } from '@expo/vector-icons';
import { useCallback, useState, useEffect } from 'react';
import AsyncStorage from '@react-native-async-storage/async-storage';
import { Invoice } from '../../types';

export default function InvoicesScreen() {
  const [invoices, setInvoices] = useState<Invoice[]>([]);

  const loadInvoices = useCallback(async () => {
    try {
      const storedInvoices = await AsyncStorage.getItem('invoices');
      if (storedInvoices) {
        setInvoices(JSON.parse(storedInvoices));
      }
    } catch (error) {
      console.error('Error loading invoices:', error);
    }
  }, []);

  useEffect(() => {
    loadInvoices();
  }, [loadInvoices]);

  const renderInvoice = ({ item }: { item: Invoice }) => (
    <TouchableOpacity style={styles.invoiceCard}>
      <View style={styles.invoiceHeader}>
        <Text style={styles.invoiceNumber}>#{item.invoiceNumber}</Text>
        <Text style={styles.invoiceDate}>{item.date}</Text>
      </View>
      <Text style={styles.clientName}>{item.clientName}</Text>
      <View style={styles.invoiceFooter}>
        <Text style={styles.totalAmount}>
          Total: ${item.items.reduce((sum, item) => sum + item.amount, 0)}
        </Text>
        <TouchableOpacity style={styles.downloadButton}>
          <Ionicons name="download-outline" size={20} color="#007AFF" />
        </TouchableOpacity>
      </View>
    </TouchableOpacity>
  );

  return (
    <View style={styles.container}>
      <Link href="/invoices/create" asChild>
        <TouchableOpacity style={styles.createButton}>
          <Ionicons name="add" size={24} color="#FFF" />
          <Text style={styles.createButtonText}>Create Invoice</Text>
        </TouchableOpacity>
      </Link>

      <FlatList
        data={invoices}
        renderItem={renderInvoice}
        keyExtractor={(item) => item.invoiceNumber}
        contentContainerStyle={styles.listContainer}
        ListEmptyComponent={
          <View style={styles.emptyState}>
            <Ionicons name="receipt-outline" size={48} color="#999" />
            <Text style={styles.emptyText}>No invoices yet</Text>
            <Text style={styles.emptySubtext}>Create your first invoice</Text>
          </View>
        }
      />
    </View>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F2F2F7',
    padding: 20,
  },
  createButton: {
    backgroundColor: '#007AFF',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
    borderRadius: 12,
    marginBottom: 20,
    gap: 8,
  },
  createButtonText: {
    color: '#FFF',
    fontSize: 16,
    fontWeight: '600',
  },
  listContainer: {
    gap: 16,
  },
  invoiceCard: {
    backgroundColor: '#FFF',
    padding: 16,
    borderRadius: 12,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
  },
  invoiceHeader: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
    marginBottom: 8,
  },
  invoiceNumber: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000',
  },
  invoiceDate: {
    fontSize: 14,
    color: '#666',
  },
  clientName: {
    fontSize: 16,
    color: '#333',
    marginBottom: 12,
  },
  invoiceFooter: {
    flexDirection: 'row',
    justifyContent: 'space-between',
    alignItems: 'center',
  },
  totalAmount: {
    fontSize: 16,
    fontWeight: '600',
    color: '#007AFF',
  },
  downloadButton: {
    padding: 8,
  },
  emptyState: {
    flex: 1,
    alignItems: 'center',
    justifyContent: 'center',
    marginTop: 100,
  },
  emptyText: {
    fontSize: 18,
    fontWeight: '600',
    color: '#000',
    marginTop: 16,
  },
  emptySubtext: {
    fontSize: 14,
    color: '#666',
    marginTop: 4,
  },
});