/**
 * User-defined function (UDF) to transform elements as part of a Dataflow
 * template job.
 *
 * @param {string} inJson input JSON message (stringified)
 * @return {?string} outJson output JSON message (stringified)
 */
function process(inJson) {
    try {
      const obj = JSON.parse(inJson);
  
      // Ensure _id is a string (MongoDB ObjectId is usually a string)
      obj._id = String(obj._id);
  
      // Convert datetime fields to ISO format
      if (obj.created_at) {
        obj.created_at = new Date(obj.created_at).toISOString();
      }
      if (obj.updated_at) {
        obj.updated_at = new Date(obj.updated_at).toISOString();
      }
  
      // Filter: Remove records with missing required fields (e.g., email, phone)
      if (!obj.email || !obj.phone) {
        return null; // Exclude this record
      }
  
      return JSON.stringify(obj);
    } catch (error) {
      console.error("Error processing record:", error);
      return null; // Exclude invalid records
    }
  }
  