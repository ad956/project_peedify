import { useState, useEffect } from "react";
import { View, Text, FlatList, Button, Alert } from "react-native";
import AsyncStorage from "@react-native-async-storage/async-storage";
import { useRouter } from "expo-router";

export default function TemplatesScreen() {
  const [templates, setTemplates] = useState([]);
  const router = useRouter();

  useEffect(() => {
    const loadTemplates = async () => {
      try {
        const storedTemplates = await AsyncStorage.getItem("templates");
        if (storedTemplates) setTemplates(JSON.parse(storedTemplates));
      } catch (error) {
        Alert.alert("Error", "Failed to load templates.");
      }
    };
    loadTemplates();
  }, []);

  return (
    <View style={{ flex: 1, padding: 20 }}>
      <Button
        title="Create New Template"
        onPress={() => router.push("/create-template")}
      />
      {templates.length === 0 ? (
        <Text>No templates found.</Text>
      ) : (
        <FlatList
          data={templates}
          keyExtractor={(item: any) => item.id}
          renderItem={({ item }) => (
            <View
              style={{
                marginVertical: 10,
                padding: 10,
                borderWidth: 1,
                borderRadius: 5,
              }}
            >
              <Text>📌 {item.businessName}</Text>
              <Text>👤 {item.ownerName}</Text>
              <Button
                title="Use Template"
                onPress={() =>
                  router.push({
                    pathname: "/fill-template/[id]",
                    params: { id: item.id },
                  })
                }
              />
            </View>
          )}
        />
      )}
    </View>
  );
}
