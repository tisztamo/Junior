import path from 'path';
import yaml from 'js-yaml';
import { loadPromptDescriptor } from "../../prompt/loadPromptDescriptor.js";
import { savePromptDescriptor } from "../../prompt/savePromptDescriptor.js";

export const updateTaskHandler = async (req, res) => {
  const task = req.body.task;
  
  try {
    const fileContent = await loadPromptDescriptor();

    const document = yaml.load(fileContent);
    document.task = path.join("prompt", "task", task);
    
    const newYamlStr = yaml.dump(document);
    await savePromptDescriptor(newYamlStr);
    
    res.status(200).json({ message: "Task updated successfully" });
  } catch (error) {
    console.log(error);
    res.status(500).json({ message: "Internal server error" });
  }
};
