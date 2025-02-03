import { useState, useEffect } from "react";
import { View, Text, TextInput, FlatList, Button, Alert } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useLocalSearchParams } from "expo-router";
import * as Print from "expo-print";
import { shareAsync } from "expo-sharing";

interface Template {
  id: string;
  businessName: string;
  columns: string[];
}

interface RowData {
  [key: string]: string;
}

export default function FillTemplateScreen() {
  const { id } = useLocalSearchParams();
  const [template, setTemplate] = useState<Template | null>(null);
  const [rows, setRows] = useState<RowData[]>([]);
  const [clientName, setClientName] = useState("");

  useEffect(() => {
    const loadTemplate = async () => {
      try {
        const storedTemplates = await AsyncStorage.getItem("templates");
        const templates: Template[] = storedTemplates
          ? JSON.parse(storedTemplates)
          : [];

        const selectedTemplate: Template | null =
          templates.find((t: Template) => t.id === id) ?? null;

        setTemplate(selectedTemplate);
      } catch (error) {
        Alert.alert("Error", "Failed to load template.");
      }
    };
    loadTemplate();
  }, [id]);

  const addRow = () => {
    setRows([...rows, {}]); // Empty row object
  };

  if (!template) return <Text>Loading...</Text>;

  const generatePDF = async () => {
    if (!clientName || rows.length === 0) {
      Alert.alert("Error", "Fill all fields before generating PDF.");
      return;
    }

    const html = `
      <html>
        <body>
          <h1>${template.businessName}</h1>
          <p>Client: ${clientName}</p>
          <table border="1" width="100%">
            <tr>${template.columns
              .map((col) => `<th>${col}</th>`)
              .join("")}</tr>
            ${rows
              .map(
                () =>
                  `<tr>${template.columns
                    .map(() => `<td>Data</td>`)
                    .join("")}</tr>`
              )
              .join("")}
          </table>
        </body>
      </html>
    `;

    const { uri } = await Print.printToFileAsync({ html });
    await shareAsync(uri);
  };

  if (!template) return <Text>Loading...</Text>;

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <Text>Client Name</Text>
      <TextInput
        value={clientName}
        onChangeText={setClientName}
        style={styles.input}
      />

      <Text>Invoice Data</Text>
      <FlatList
        data={rows}
        keyExtractor={(item, index) => index.toString()}
        renderItem={() => (
          <TextInput style={styles.input} placeholder="Enter row data" />
        )}
      />

      <Button title="Add Row" onPress={addRow} />
      <Button title="Generate PDF" onPress={generatePDF} />
    </View>
  );
}

const styles = {
  input: { borderWidth: 1, padding: 10, marginVertical: 5, borderRadius: 5 },
};
