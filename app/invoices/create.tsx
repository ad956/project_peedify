import { useState, useEffect } from 'react';
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
import { Template, Invoice, InvoiceItem } from '../../types';
import * as Print from 'expo-print';
import { shareAsync } from 'expo-sharing';

export default function CreateInvoiceScreen() {
  const [templates, setTemplates] = useState<Template[]>([]);
  const [selectedTemplate, setSelectedTemplate] = useState<Template | null>(null);
  const [clientName, setClientName] = useState('');
  const [clientEmail, setClientEmail] = useState('');
  const [clientPhone, setClientPhone] = useState('');
  const [clientAddress, setClientAddress] = useState('');
  const [items, setItems] = useState<InvoiceItem[]>([]);

  useEffect(() => {
    loadTemplates();
  }, []);

  const loadTemplates = async () => {
    try {
      const storedTemplates = await AsyncStorage.getItem('templates');
      if (storedTemplates) {
        setTemplates(JSON.parse(storedTemplates));
      }
    } catch (error) {
      console.error('Error loading templates:', error);
    }
  };

  const addItem = () => {
    setItems([...items, { description: '', quantity: 0, rate: 0, amount: 0 }]);
  };

  const updateItem = (index: number, field: keyof InvoiceItem, value: string) => {
    const newItems = [...items];
    const item = { ...newItems[index] };

    if (field === 'description') {
      item.description = value;
    } else {
      const numValue = parseFloat(value) || 0;
      item[field] = numValue;

      if (field === 'quantity' || field === 'rate') {
        item.amount = item.quantity * item.rate;
      }
    }

    newItems[index] = item;
    setItems(newItems);
  };

  const removeItem = (index: number) => {
    setItems(items.filter((_, i) => i !== index));
  };

  const calculateTotal = () => {
    return items.reduce((sum, item) => sum + item.amount, 0);
  };

  const generatePDF = async () => {
    if (!selectedTemplate || !clientName || items.length === 0) {
      Alert.alert('Error', 'Please fill in all required fields');
      return;
    }

    const invoice: Invoice = {
      invoiceNumber: `INV-${Date.now()}`,
      date: new Date().toISOString().split('T')[0],
      dueDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000)
        .toISOString()
        .split('T')[0],
      clientName,
      clientEmail,
      clientPhone,
      clientAddress,
      items,
      template: selectedTemplate,
      subtotal: calculateTotal(),
      tax: calculateTotal() * 0.1,
      total: calculateTotal() * 1.1,
    };

    const html = generateInvoiceHTML(invoice);

    try {
      const { uri } = await Print.printToFileAsync({ html });
      await shareAsync(uri, { UTI: '.pdf', mimeType: 'application/pdf' });

      const existingInvoices = await AsyncStorage.getItem('invoices');
      const invoices = existingInvoices ? JSON.parse(existingInvoices) : [];
      await AsyncStorage.setItem(
        'invoices',
        JSON.stringify([...invoices, invoice])
      );

      router.back();
    } catch (error) {
      Alert.alert('Error', 'Failed to generate PDF');
    }
  };

  return (
    <ScrollView style={styles.container}>
      <Text style={styles.title}>Create Invoice</Text>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Select Template</Text>
        <ScrollView horizontal showsHorizontalScrollIndicator={false}>
          {templates.map((template) => (
            <TouchableOpacity
              key={template.id}
              style={[
                styles.templateCard,
                selectedTemplate?.id === template.id && styles.selectedTemplate,
              ]}
              onPress={() => setSelectedTemplate(template)}>
              <Text style={styles.templateName}>{template.businessName}</Text>
            </TouchableOpacity>
          ))}
        </ScrollView>
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Client Details</Text>
        <TextInput
          style={styles.input}
          placeholder="Client Name"
          value={clientName}
          onChangeText={setClientName}
        />
        <TextInput
          style={styles.input}
          placeholder="Email"
          value={clientEmail}
          onChangeText={setClientEmail}
          keyboardType="email-address"
          autoCapitalize="none"
        />
        <TextInput
          style={styles.input}
          placeholder="Phone"
          value={clientPhone}
          onChangeText={setClientPhone}
          keyboardType="phone-pad"
        />
        <TextInput
          style={styles.input}
          placeholder="Address"
          value={clientAddress}
          onChangeText={setClientAddress}
          multiline
        />
      </View>

      <View style={styles.section}>
        <Text style={styles.sectionTitle}>Invoice Items</Text>
        {items.map((item, index) => (
          <View key={index} style={styles.itemContainer}>
            <TextInput
              style={styles.itemInput}
              placeholder="Description"
              value={item.description}
              onChangeText={(value) => updateItem(index, 'description', value)}
            />
            <View style={styles.itemDetails}>
              <TextInput
                style={styles.numberInput}
                placeholder="Qty"
                value={item.quantity.toString()}
                onChangeText={(value) => updateItem(index, 'quantity', value)}
                keyboardType="numeric"
              />
              <TextInput
                style={styles.numberInput}
                placeholder="Rate"
                value={item.rate.toString()}
                onChangeText={(value) => updateItem(index, 'rate', value)}
                keyboardType="numeric"
              />
              <Text style={styles.amount}>${item.amount}</Text>
              <TouchableOpacity
                onPress={() => removeItem(index)}
                style={styles.removeButton}>
                <Ionicons name="trash-outline" size={20} color="#FF3B30" />
              </TouchableOpacity>
            </View>
          </View>
        ))}
        <TouchableOpacity onPress={addItem} style={styles.addButton}>
          <Ionicons name="add" size={24} color="#FFF" />
          <Text style={styles.addButtonText}>Add Item</Text>
        </TouchableOpacity>
      </View>

      <View style={styles.totalSection}>
        <Text style={styles.totalText}>Total: ${calculateTotal()}</Text>
      </View>

      <TouchableOpacity onPress={generatePDF} style={styles.generateButton}>
        <Text style={styles.generateButtonText}>Generate Invoice</Text>
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
  templateCard: {
    backgroundColor: '#FFF',
    padding: 16,
    borderRadius: 12,
    marginRight: 12,
    minWidth: 160,
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 2 },
    shadowOpacity: 0.1,
    shadowRadius: 8,
    elevation: 3,
  },
  selectedTemplate: {
    backgroundColor: '#E3F2FD',
    borderColor: '#007AFF',
    borderWidth: 2,
  },
  templateName: {
    fontSize: 16,
    fontWeight: '500',
    color: '#000',
  },
  input: {
    backgroundColor: '#FFF',
    padding: 12,
    borderRadius: 8,
    marginBottom: 12,
    fontSize: 16,
  },
  itemContainer: {
    backgroundColor: '#FFF',
    padding: 12,
    borderRadius: 8,
    marginBottom: 12,
  },
  itemInput: {
    fontSize: 16,
    marginBottom: 8,
  },
  itemDetails: {
    flexDirection: 'row',
    alignItems: 'center',
    gap: 8,
  },
  numberInput: {
    backgroundColor: '#F2F2F7',
    padding: 8,
    borderRadius: 6,
    width: 80,
    fontSize: 16,
  },
  amount: {
    flex: 1,
    fontSize: 16,
    fontWeight: '500',
    color: '#007AFF',
    textAlign: 'right',
  },
  removeButton: {
    padding: 8,
  },
  addButton: {
    backgroundColor: '#007AFF',
    flexDirection: 'row',
    alignItems: 'center',
    justifyContent: 'center',
    padding: 16,
    borderRadius: 12,
    gap: 8,
  },
  addButtonText: {
    color: '#FFF',
    fontSize: 16,
    fontWeight: '600',
  },
  totalSection: {
    backgroundColor: '#FFF',
    padding: 16,
    borderRadius: 12,
    marginBottom: 24,
  },
  totalText: {
    fontSize: 20,
    fontWeight: 'bold',
    color: '#007AFF',
    textAlign: 'right',
  },
  generateButton: {
    backgroundColor: '#34C759',
    padding: 16,
    borderRadius: 12,
    alignItems: 'center',
    marginBottom: 40,
  },
  generateButtonText: {
    color: '#FFF',
    fontSize: 16,
    fontWeight: '600',
  },
});

function generateInvoiceHTML(invoice: Invoice): string {
  return `<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <title>Invoice ${invoice.invoiceNumber}</title>
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
        line-height: 1.5;
        padding: 40px;
        max-width: 800px;
        margin: 0 auto;
      }
      .header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 40px;
      }
      .business-details {
        margin-bottom: 40px;
      }
      .client-details {
        margin-bottom: 40px;
      }
      table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 40px;
      }
      th, td {
        padding: 12px;
        text-align: left;
        border-bottom: 1px solid #E5E5EA;
      }
      th {
        background-color: #F2F2F7;
        font-weight: 600;
      }
      .totals {
        margin-left: auto;
        width: 300px;
      }
      .total-row {
        display: flex;
        justify-content: space-between;
        padding: 8px 0;
      }
      .total-row.final {
        font-weight: bold;
        font-size: 1.2em;
        border-top: 2px solid #000;
        margin-top: 8px;
        padding-top: 16px;
      }
    </style>
  </head>
  <body>
    <div class="header">
      <div class="business-details">
        <h1>${invoice.template.businessName}</h1>
        <p>${invoice.template.address}</p>
        <p>${invoice.template.phone}</p>
        <p>${invoice.template.email}</p>
      </div>
      <div>
        <h2>Invoice ${invoice.invoiceNumber}</h2>
        <p>Date: ${invoice.date}</p>
        <p>Due Date: ${invoice.dueDate}</p>
      </div>
    </div>

    <div class="client-details">
      <h3>Bill To:</h3>
      <p>${invoice.clientName}</p>
      <p>${invoice.clientAddress}</p>
      <p>${invoice.clientPhone}</p>
      <p>${invoice.clientEmail}</p>
    </div>

    <table>
      <thead>
        <tr>
          ${invoice.template.columns
            .map((column) => `<th>${column}</th>`)
            .join('')}
        </tr>
      </thead>
      <tbody>
        ${invoice.items
          .map(
            (item) => `
          <tr>
            <td>${item.description}</td>
            <td>${item.quantity}</td>
            <td>$${item.rate}</td>
            <td>$${item.amount}</td>
          </tr>
        `
          )
          .join('')}
      </tbody>
    </table>

    <div class="totals">
      <div class="total-row">
        <span>Subtotal:</span>
        <span>$${invoice.subtotal}</span>
      </div>
      <div class="total-row">
        <span>Tax (10%):</span>
        <span>$${invoice.tax}</span>
      </div>
      <div class="total-row final">
        <span>Total:</span>
        <span>$${invoice.total}</span>
      </div>
    </div>
  </body>
</html>`;
}