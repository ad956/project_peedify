import { useState } from "react";
import { View, Text, TextInput, Button, FlatList, Alert } from "react-native";
import { useRouter } from "expo-router";
import AsyncStorage from "@react-native-async-storage/async-storage";

export default function CreateTemplateScreen() {
  const router = useRouter();
  const [businessName, setBusinessName] = useState("");
  const [ownerName, setOwnerName] = useState("");
  const [contact, setContact] = useState("");
  const [columns, setColumns] = useState<string[]>([]);
  const [columnInput, setColumnInput] = useState("");

  const addColumn = () => {
    if (columnInput.trim() !== "") {
      setColumns([...columns, columnInput.trim()]);
      setColumnInput("");
    }
  };

  const saveTemplate = async () => {
    if (!businessName || !ownerName || !contact || columns.length === 0) {
      Alert.alert(
        "Error",
        "Please fill all fields and add at least one column."
      );
      return;
    }

    const newTemplate = {
      id: Date.now().toString(),
      businessName,
      ownerName,
      contact,
      columns,
    };

    // Save to AsyncStorage
    try {
      const existingTemplates = await AsyncStorage.getItem("templates");
      const templates = existingTemplates ? JSON.parse(existingTemplates) : [];
      templates.push(newTemplate);
      await AsyncStorage.setItem("templates", JSON.stringify(templates));

      Alert.alert("Success", "Template saved!");
      router.push("/templates");
    } catch (error) {
      Alert.alert("Error", "Failed to save template.");
    }
  };

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <Text>Business Name</Text>
      <TextInput
        value={businessName}
        onChangeText={setBusinessName}
        style={styles.input}
      />

      <Text>Owner Name</Text>
      <TextInput
        value={ownerName}
        onChangeText={setOwnerName}
        style={styles.input}
      />

      <Text>Contact</Text>
      <TextInput
        value={contact}
        onChangeText={setContact}
        style={styles.input}
      />

      <Text>Invoice Columns</Text>
      <TextInput
        value={columnInput}
        onChangeText={setColumnInput}
        style={styles.input}
        placeholder="e.g. Item Name"
      />
      <Button title="Add Column" onPress={addColumn} />

      <FlatList
        data={columns}
        keyExtractor={(item, index) => index.toString()}
        renderItem={({ item }) => <Text>{item}</Text>}
      />

      <Button title="Save Template" onPress={saveTemplate} />
    </View>
  );
}

const styles = {
  input: { borderWidth: 1, padding: 10, marginVertical: 5, borderRadius: 5 },
};
